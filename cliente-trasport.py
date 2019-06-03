import os
import sys

messageReceived = 'CLIENT4-CLIENT3-mensagem.txt'
segmentSent = 'CLIENT3-CLIENT1-segmento.txt'

segmentReceived = 'CLIENT1-CLIENT3-segmento.txt'
messageSent = 'CLIENT3-CLIENT4-mensgem.txt'


def getFileLength(filename):
    return os.stat(filename).st_size


def getAllFileContent(filename):
    file = open(filename, 'r')
    return "DATA:\n" + file.read()


def getOnlyFileData(filename):

    file = open(filename, 'r')
    reachedBody = False
    body = ""

    for line in file:
        if reachedBody:
            body += line
        if line == "DATA:\n":
            reachedBody = True

    print(body)
    return body


def getMessageSequence():
    return 1


def TCPHeader(srcPort, dstPort, length, checksum):
    # Implementar
    header = ""
    return header


def UPDHeader(srcPort, dstPort, length, checksum):
    header = "SRCPORT: " + str(srcPort) + ", DSTPORT: " + str(dstPort) + \
        "\nLENGTH: " + str(length) + \
        ", CHKSUM: " + str(checksum) + '\n'

    return header


def writeOutput(outputFile, header, body):
    print(header)
    print(body)
    file = open(outputFile, 'w')
    file.write(header)
    file.write(body)
    file.close()


# sys.argv[1] => opcao que diz se esta enviando ou recebendo mensagem
sending = sys.argv[1] == "send"
receiving = sys.argv[1] == "receive"
# sys.argv[2] => opcao que diz se esta usando UDP ou TCP
udp = sys.argv[2] == "udp"
tcp = sys.argv[2] == "tcp"

if sending:
    print("Client reading from APP layer, sending to PHY layer")
    inputFile = messageReceived
    outputFile = segmentSent

    if udp:
        srcPort = 3000
        dstPort = 25

        body = getAllFileContent(inputFile)
        length = getFileLength(inputFile)
        checksum = 0

        print("Using UDP\n")
        header = UPDHeader(srcPort, dstPort, length, checksum)

        writeOutput(outputFile, header, body)

if receiving:
    print("Client reading from PHY layer, sending to APP layer")
    inputFile = segmentReceived
    outputFile = messageSent

    if udp:
        writeOutput(outputFile, '', getOnlyFileData(inputFile))
