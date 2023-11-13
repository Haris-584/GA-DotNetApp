FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

# comment 1

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .

# Set a placeholder for the version number
ENV APP_VERSION=1.0

ENTRYPOINT ["dotnet", "DotNetApp.dll"]
