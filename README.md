# freepbx-docker
Repositório da imagem do FreePBX para Docker

Descrição
-----------

Essa imagem foi criada para utilização da instalação do FreePBX em projetos com Docker

**Necessário Docker instalado na máquina**
Referência para instalação: https://docs.docker.com/install/

**Como usar:**

1) Utilizar o comando run para seu funcionamento:

```
docker run -it --rm leucotron/freepbx:17.0
```

**Dicas:**

1) Geração de novas versões:
Para gerar uma nova imagem com nova versão de FreePBX, nesse caso do exemplo abaixo, usamos a versão 17.0 alterando a ENV FREEPBX_VERSION. Além disso, 
ainda podemos definir a versão do Asterisk através do ENV ASTERISK_VERSION, que nesta ultima geração está na versão 20.5.2

```
docker build -t leucotron/freepbx:17.0 .
```

2) Disponibilizar a imagem no Docker Hub:
Para autenticar seu usuário do Docker Hub

```
docker login
```

Para enviar as modificações para o repositório:

```
docker push leucotron/freepbx:17.0
```

Para gerar a versão "latest", basta substituir a TAG de versão por "latest" em todos os comandos apresentados acima. Referência: https://docs.docker.com/docker-hub/repos/

Dockerfile disponível em "src" e toda documentação do Docker se encontra em https://docs.docker.com/
