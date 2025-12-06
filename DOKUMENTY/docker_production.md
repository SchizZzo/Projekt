# Instalacja Dockera na Debianie 13 (Trixie) i wdrożenie produkcyjne

Poniższa procedura przygotowuje środowisko do uruchomienia stacka **joker_chat_swarm_stack** w trybie produkcyjnym. Instrukcje zakładają posiadanie uprawnień `sudo` (użytkownik dodany do grupy `sudo`).

## 1. Wymagane pakiety systemowe

```bash
apt update
apt install -y passwd login sudo util-linux

/usr/sbin/usermod -aG sudo dawid
```

## 2. Narzędzia do zarządzania repozytoriami APT

```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release
```

## 3. Klucz GPG i repozytorium Dockera

```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

## 4. Pełne repozytoria Debiana 13

W pliku `/etc/apt/sources.list` zakomentuj wpis z napędem CD-ROM, a następnie dodaj oficjalne repozytoria:

```
deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware
deb http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
```

Zaktualizuj listę pakietów:

```bash
sudo apt update
```

> Bez pełnych repozytoriów pakiety zależne (np. `iptables`) mogą być niedostępne.

## 5. Instalacja Docker Engine, CLI i Containerd

```bash
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Zweryfikuj działanie:

```bash
sudo systemctl status docker
sudo docker run hello-world
```

## 6. Przydatne komendy Docker/Swarm

```bash
sudo docker ps
sudo docker pull ghcr.io/schizzzo/joker_chat_swarm_frontend:latest
sudo docker stack deploy -c stack.yml joker_chat_swarm_stack
sudo docker stack rm joker_chat_swarm_stack
sudo docker exec -it 5d950ec6fd3e python manage.py collectstatic
sudo docker stack deploy -c stack.yml joker_chat_swarm_stack
```

## 7. Wdrażanie w produkcji

1. **Logowanie do rejestru GHCR (opcjonalnie do pushowania własnych obrazów):**
   ```bash
   echo "<GITHUB_PAT>" | docker login ghcr.io -u schizzzo --password-stdin
   ```
2. **Budowa obrazu backendu:**
   ```bash
   docker build -t joker_chat_swarm_backend:latest .
   ```
3. **Tagowanie i publikacja obrazu backendu w GHCR:**
   ```bash
   docker tag joker_chat_swarm_backend:latest ghcr.io/schizzzo/joker_chat_swarm_backend:latest
   docker push ghcr.io/schizzzo/joker_chat_swarm_backend:latest
   ```
4. **Tagowanie i publikacja obrazu frontendu (gdy budujesz lokalnie):**
   ```bash
   docker tag joker_chat_swarm_frontend:latest ghcr.io/schizzzo/joker_chat_swarm_frontend:latest
   docker push ghcr.io/schizzzo/joker_chat_swarm_frontend:latest
   ```
5. **Pobranie aktualnych obrazów i wdrożenie stacka:**
   ```bash
   sudo docker pull ghcr.io/schizzzo/joker_chat_swarm_frontend:latest
   sudo docker stack deploy -c stack.yml joker_chat_swarm_stack
   ```
6. **Obsługa statycznych plików Django (po migracjach/aktualizacjach):**
   ```bash
   sudo docker exec -it <backend_container_id> python manage.py collectstatic
   ```
7. **Cloudflare Tunnel:** aplikacja nasłuchuje na porcie 80; zmieniasz jedynie hostname w tunelu, port pozostaje 80.

Po wdrożeniu stacka zweryfikuj usługi komendą `sudo docker ps` oraz ewentualnie `sudo docker service ls` w zależności od konfiguracji.
