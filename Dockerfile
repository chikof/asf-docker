FROM alpine

# Since the wget version included in Alpine is a small version, we also install curl (the dotnet script will use it)
RUN apt install --no-cache bash curl libc6-compat libgcc icu-libs krb5-libs libssl1.1 libstdc++ zlib
RUN apt install --no-cache libgdiplus --repository https://dl-3.alpinelinux.org/alpine/edge/testing/
RUN wget -q https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh -O /tmp/dotnet-install.sh
RUN chmod +x /tmp/dotnet-install.sh
RUN /tmp/dotnet-install.sh --runtime aspnetcore -v 5.0.0
RUN wget https://github.com/JustArchiNET/ArchiSteamFarm/releases/latest/download/ASF-generic.zip -O /tmp/ASF.zip
RUN unzip /tmp/ASF.zip -d /asf
RUN echo '{"Kestrel": {"Endpoints": {"HTTP": {"Url": "http://*:1242"}}}}' > /asf/config/IPC.config
RUN echo '{"AutoRestart": true,"IPC": true,"Headless": true}' > /asf/config/ASF.json

CMD ["/root/.dotnet/dotnet", "/asf/ArchiSteamFarm.dll"]
