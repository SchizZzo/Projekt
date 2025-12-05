from django.db import migrations, models


def create_default_documents(apps, schema_editor):
    SiteDocument = apps.get_model("login", "SiteDocument")
    documents = [
        ("terms", "regulamin", "Regulamin"),
        ("privacy", "polityka-prywatnosci", "Polityka prywatności"),
        (
            "minor_protection",
            "standardy-ochrony-maloletnich",
            "Standardy ochrony małoletnich",
        ),
    ]

    for document_type, slug, title in documents:
        SiteDocument.objects.update_or_create(
            document_type=document_type,
            defaults={
                "slug": slug,
                "title": title,
                "content": "Treść dokumentu zostanie wkrótce uzupełniona.",
            },
        )


def delete_default_documents(apps, schema_editor):
    SiteDocument = apps.get_model("login", "SiteDocument")
    SiteDocument.objects.filter(
        document_type__in=["terms", "privacy", "minor_protection"]
    ).delete()


class Migration(migrations.Migration):

    dependencies = [
        ("login", "0002_alter_customuser_display_name"),
    ]

    operations = [
        migrations.CreateModel(
            name="SiteDocument",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                (
                    "document_type",
                    models.CharField(
                        choices=[
                            ("terms", "Regulamin"),
                            ("privacy", "Polityka prywatności"),
                            ("minor_protection", "Standardy ochrony małoletnich"),
                        ],
                        max_length=32,
                        unique=True,
                    ),
                ),
                ("slug", models.SlugField(max_length=100, unique=True)),
                ("title", models.CharField(max_length=255)),
                ("content", models.TextField()),
                ("updated_at", models.DateTimeField(auto_now=True)),
            ],
            options={"ordering": ["title"]},
        ),
        migrations.RunPython(create_default_documents, reverse_code=delete_default_documents),
    ]
