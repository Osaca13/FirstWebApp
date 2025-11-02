# Docker build & run (FirstWebApp)

This file describes how to build and run the `FirstWebApp` Docker image on your machine (PowerShell examples).

1) Build the image (run in project root):

```powershell
docker build -t firstwebapp:latest .
```

2) Run the container, mapping port 8080 on the host to port 80 in the container:

```powershell
docker run -d --name firstwebapp -p 8080:80 firstwebapp:latest
```

3) Open in browser:

http://localhost:8080/

Notes and variants:
- If you prefer another host port, change `-p HOSTPORT:80`.
- For production images you can add trimming/single-file publish flags in the `dotnet publish` step (e.g. `/p:PublishSingleFile=true /p:PublishTrimmed=true`) but test thoroughly.
- For multi-arch builds (ARM + x64) consider `docker buildx`.
