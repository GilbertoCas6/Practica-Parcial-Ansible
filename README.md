Práctica Parcial – Ansible

Automatización de un servidor web Nginx en dos nodos Docker usando Ansible.
El playbook instala Nginx y despliega un index.html personalizado.

Arquitectura

node1 y node2: contenedores Ubuntu con openssh-server y Python para gestión vía Ansible.

Control: Ansible se ejecuta en un contenedor efímero (cytopia/ansible) montando este repo.

Puertos publicados:

node1 → http://localhost:8080

node2 → http://localhost:8081

Estructura
.
├─ ansible.cfg
├─ docker-compose.yml
├─ Dockerfile
├─ inventory.ini
└─ playbooks/
   ├─ web.yml
   └─ files/
      └─ siteindex.html

Requisitos

Docker Desktop (con Compose)

Windows 10/11

Git Bash o CMD/PowerShell

Cómo ejecutar

Opción A: CMD/PowerShell (Windows)
REM 1) Levantar nodos
docker compose up -d --build

REM 2) Ejecutar playbook
docker run --rm --network ansible-docker-lab_default ^
  -v "%cd%:/ansible" ^
  -v "%cd%\ansible.cfg:/etc/ansible/ansible.cfg:ro" ^
  -w /ansible cytopia/ansible:latest ^
  sh -lc "apk add --no-cache sshpass openssh-client >nul && ansible-playbook -i inventory.ini playbooks/web.yml -vv"


Opción B: Git Bash (Windows)
# 1) Levantar
docker compose up -d --build
# 2) Playbook
docker run --rm --network ansible-docker-lab_default
-v "$(pwd -W):/ansible"
-v "$(pwd -W)/ansible.cfg:/etc/ansible/ansible.cfg:ro"
-w /ansible cytopia/ansible:latest
sh -lc "apk add --no-cache sshpass openssh-client >/dev/null && ansible-playbook -i inventory.ini playbooks/web.yml -vv"

Verificación rápida
curl http://localhost:8080
curl http://localhost:8081

Limpieza
docker compose down -v
.
├─ ansible.cfg
├─ docker-compose.yml
├─ Dockerfile
├─ inventory.ini
└─ playbooks/
├─ web.yml
└─ files/
└─ index.html

## Requisitos
- Docker Desktop (con Compose)
- Windows 10/11
- Git Bash o CMD/PowerShell

## Cómo ejecutar

### Opción A: CMD/PowerShell (Windows)
```bat
REM 1) Levantar nodos
docker compose up -d --build

REM 2) Ejecutar playbook
docker run --rm --network ansible-docker-lab_default ^
  -v "%cd%:/ansible" ^
  -v "%cd%\ansible.cfg:/etc/ansible/ansible.cfg:ro" ^
  -w /ansible cytopia/ansible:latest ^
  sh -lc "apk add --no-cache sshpass openssh-client >/dev/null && ansible-playbook -i inventory.ini playbooks/web.yml -vv"

