# Multi-stage Dockerfile for FirstWebApp (ASP.NET Core / .NET 10)
#
# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy csproj and restore to leverage Docker layer caching
COPY ["FirstWebApp.csproj", "./"]
RUN dotnet restore "FirstWebApp.csproj"

# Copy everything else and publish
COPY . .
RUN dotnet publish "FirstWebApp.csproj" -c Release -r win-x64 -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .

# Listen on port 80 inside container
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

ENTRYPOINT ["dotnet", "FirstWebApp.dll"]
