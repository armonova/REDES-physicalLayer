using System;

namespace camada_rede
{
    public class Program
    {
        public static HostsTableService hostsTableService = new HostsTableService();
        public static FilesService filesService = new FilesService();
        public static NetworkServices networkService = new NetworkServices();
        public static string hostsPath = "hostsTable.json";
        public static Configuration config;

        public static void Main(string[] args)
        {
            if (args.Length < 2)
            {
                Console.WriteLine("Error: there's no specification if you are a client or server\n\n\tdotnet run [CLIENT or SERVER] [SENDING or RECEIVING]\n");
                return;
            }
            if (args[0] == "client")
            {
                ExecuteClientNetwork(args[1]);
            }
            else if (args[0] == "server")
            {
                ExecuteServerNetwork(args[1]);
            }
            else
            {
                Console.WriteLine("Error: there's no specification if you are a client or server\n\n\tdotnet run [CLIENT or SERVER] [SENDING or RECEIVING]\n");
                return;
            }

        }

        public static void ExecuteClientNetwork(string role)
        {
            //initial configuration (my ip and my mask)
            config = new Configuration()
            {
                Ip = "172.16.251.15",
                Mask = "255.255.255.0"
            };

            if (role == "sending")
            {
                var destinationIP = "172.16.251.17";

                //read from CLIENT3-CLIENT2-segmento.txt
                var segmento = filesService.ReadFile("CLIENT3-CLIENT2-segmento.txt");

                //check if is sending to gateway or the destination is in the same sub network
                if (networkService.IsIPInMyNetwork(config.Ip, destinationIP, config.Mask))
                {
                    // write to CLIENT2-CLIENT1-pacote.txt
                    var pacote = filesService.WriteIpPDU(config.Ip, destinationIP, segmento);
                    filesService.WriteToFile("CLIENT2-CLIENT1-pacote.txt", pacote);
                }
                else
                {
                    Console.WriteLine("Acting as a gateway");
                    var hostsTable = hostsTableService.GetHosts(hostsPath);

                    var host = hostsTableService.CheckIP(config.Ip, destinationIP, config.Mask);
                    Console.Write(host);

                    //write to CLIENT2-CLIENT1-pacote.txt    filesService.WriteFile(path, content);
                    var pacote = filesService.WriteIpPDU(config.Ip, destinationIP, segmento);
                    filesService.WriteToFile("CLIENT2-CLIENT1-pacote.txt", pacote);
                }
            }
            else if (role == "receiving")
            {
                var pdu = filesService.ReadFile("SERVER1-SERVER2-quadro.txt");
            }

        }

        public static void ExecuteServerNetwork(string role)
        {
            //initial configuration (my ip and my mask)
            config = new Configuration()
            {
                Ip = "172.16.251.15",
                Mask = "255.255.255.0"
            };

            var pdu = filesService.ReadFile("SERVER1-SERVER2-quadro.txt");
            var sourceIp = filesService.GetSourceIp(pdu);
            var destinationIP = filesService.GetDestinationIp(pdu);
            var data = filesService.RemovePhysicalLayerHeader(pdu);

            if (destinationIP == config.Ip)
            {
                Console.WriteLine($"I'm the final destination. Removing header and writing to transport layer (SERVER2-SERVER3-pacote.txt)");
                Console.WriteLine(data);
                filesService.WriteToFile("SERVER2-SERVER3-pacote.txt", data);
            }
            else
            {
                //Acting as a gateway
                Console.WriteLine($"I'm not the final destination. Acting as a gateway");

                var hostsTable = hostsTableService.GetHosts(hostsPath);

                var host = hostsTableService.CheckIP(config.Ip, destinationIP, config.Mask);
                Console.WriteLine(host);

                //write to CLIENT2-CLIENT1-pacote.txt
                var pacote = filesService.WriteIpPDU(config.Ip, host.NetworkIP, data);
                filesService.WriteToFile("CLIENT2-CLIENT1-pacote.txt", pacote);
            }
        }
    }
}
