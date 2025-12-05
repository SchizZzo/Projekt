import { useEffect, useMemo, useState } from 'react';
import { useParams } from 'react-router-dom';
import { apiRequest } from '../api/client.js';

const escapeHtml = (text) =>
  text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');

const formatInlineMarkdown = (text) => {
  let escaped = escapeHtml(text);

  escaped = escaped.replace(/`([^`]+)`/g, '<code>$1</code>');
  escaped = escaped.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>');
  escaped = escaped.replace(/(?:\*|_)\b([^*_]+)\b(?:\*|_)/g, '<em>$1</em>');
  escaped = escaped.replace(
    /\[([^\]]+)\]\((https?:\/\/[^\s)]+)\)/g,
    '<a href="$2" target="_blank" rel="noopener noreferrer">$1</a>',
  );

  return escaped;
};

const convertMarkdownToHtml = (markdown = '') => {
  const lines = markdown.split(/\r?\n/);
  const htmlParts = [];
  let unorderedItems = [];
  let orderedItems = [];
  let codeLines = [];
  let inCodeBlock = false;

  const flushLists = () => {
    if (unorderedItems.length) {
      htmlParts.push(`<ul>${unorderedItems
        .map((item) => `<li>${formatInlineMarkdown(item)}</li>`)
        .join('')}</ul>`);
      unorderedItems = [];
    }

    if (orderedItems.length) {
      htmlParts.push(`<ol>${orderedItems
        .map((item) => `<li>${formatInlineMarkdown(item)}</li>`)
        .join('')}</ol>`);
      orderedItems = [];
    }
  };

  lines.forEach((line) => {
    if (line.trim().startsWith('```')) {
      if (inCodeBlock) {
        htmlParts.push(`<pre><code>${escapeHtml(codeLines.join('\n'))}</code></pre>`);
        codeLines = [];
        inCodeBlock = false;
      } else {
        flushLists();
        inCodeBlock = true;
      }
      return;
    }

    if (inCodeBlock) {
      codeLines.push(line);
      return;
    }

    const unorderedMatch = line.match(/^\s*[-*]\s+(.*)$/);
    if (unorderedMatch) {
      unorderedItems.push(unorderedMatch[1]);
      return;
    }

    const orderedMatch = line.match(/^\s*\d+\.\s+(.*)$/);
    if (orderedMatch) {
      orderedItems.push(orderedMatch[1]);
      return;
    }

    flushLists();

    if (!line.trim()) {
      return;
    }

    const headingMatch = line.match(/^(#{1,6})\s+(.*)$/);
    if (headingMatch) {
      const level = headingMatch[1].length;
      htmlParts.push(`<h${level}>${formatInlineMarkdown(headingMatch[2])}</h${level}>`);
      return;
    }

    if (line.trim().startsWith('>')) {
      htmlParts.push(
        `<blockquote>${formatInlineMarkdown(line.replace(/^>\s?/, ''))}</blockquote>`,
      );
      return;
    }

    htmlParts.push(`<p>${formatInlineMarkdown(line)}</p>`);
  });

  if (inCodeBlock) {
    htmlParts.push(`<pre><code>${escapeHtml(codeLines.join('\n'))}</code></pre>`);
  }

  flushLists();

  return htmlParts.join('');
};

function DocumentPage() {
  const { slug } = useParams();
  const [documentData, setDocumentData] = useState(null);
  const [error, setError] = useState(null);
  const [isLoading, setIsLoading] = useState(true);
  const renderedContent = useMemo(
    () => convertMarkdownToHtml(documentData?.content),
    [documentData?.content],
  );

  useEffect(() => {
    const controller = new AbortController();

    const fetchDocument = async () => {
      setIsLoading(true);
      setError(null);

      try {
        const response = await apiRequest(
          `/joker-login-api/documents/${slug}/`,
          { signal: controller.signal },
          { useAuth: false, retryOnAuthFail: false },
        );

        if (!response.ok) {
          throw new Error('Nie udało się pobrać treści dokumentu.');
        }

        const data = await response.json();
        setDocumentData(data);
      } catch (fetchError) {
        if (fetchError.name === 'AbortError') {
          return;
        }
        setError(fetchError.message || 'Wystąpił błąd podczas pobierania dokumentu.');
      } finally {
        setIsLoading(false);
      }
    };

    fetchDocument();

    return () => controller.abort();
  }, [slug]);

  return (
    <div className="card stack document-card">
      {isLoading && <p className="subtitle">Ładowanie treści...</p>}
      {!isLoading && error && <p className="subtitle error-text">{error}</p>}
      {!isLoading && !error && documentData && (
        <>
          <div>
            <p className="badge">Aktualizacja: {new Date(documentData.updated_at).toLocaleDateString('pl-PL')}</p>
            <h1 className="document-title">{documentData.title}</h1>
          </div>
          <div className="document-content" dangerouslySetInnerHTML={{ __html: renderedContent }} />
        </>
      )}
    </div>
  );
}

export default DocumentPage;
