import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { apiRequest } from '../api/client.js';

function DocumentPage() {
  const { slug } = useParams();
  const [documentData, setDocumentData] = useState(null);
  const [error, setError] = useState(null);
  const [isLoading, setIsLoading] = useState(true);

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
          <div className="document-content">
            {documentData.content.split('\n').map((paragraph, index) => (
              <p key={`paragraph-${index}`}>{paragraph}</p>
            ))}
          </div>
        </>
      )}
    </div>
  );
}

export default DocumentPage;
