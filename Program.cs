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
                Ip = "192.168.1.0",
                Mask = "255.255.255.0"
            };

            if (role == "sending")
            {
                //read from CLIENT3-CLIENT2-segmento.txt
                var destinationIP = "192.168.2.0";

                //check if is sending to gateway or the destination is in the same sub network
                if (networkService.IsIPInMyNetwork("192.168.1.0", "192.168.2.0", "255.255.255.0"))
                {
                    //write to CLIENT2-CLIENT1-pacote.txt
                }
                else
                {
                    Console.WriteLine("Acting as a gateway");
                    var hostsTable = hostsTableService.GetHosts(hostsPath);

                    var host = hostsTableService.CheckIP(config.Ip, destinationIP, config.Mask);
                    Console.Write(host);

                    //write to CLIENT2-CLIENT1-pacote.txt    filesService.WriteFile(path, content);
                }
            }
            else if (role == "receiving")
            {
                var content = filesService.ReadFile("");
            }
            else
            {

            }
        }

        public static void ExecuteServerNetwork(string role)
        {
            //initial configuration (my ip and my mask)
            config = new Configuration()
            {
                Ip = "192.168.1.0",
                Mask = "255.255.255.0"
            };

            var data = filesService.ReadFile("SERVER1-SERVER3-quadro.txt");
            //filesService.WriteIpPDU()
        }
    }
}
