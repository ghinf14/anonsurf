import httpClient
import strutils
import xmltree
import htmlparser


proc parseIPbyTorServer(data: string): string =
  #[
    Get IP address and current status from Tor server
  ]#

  let ipAddr = parseHtml(data).findAll("strong")[0].innerText
  let status = parseHtml(data).findAll("title")[0].innerText
  return "Your address is: " & ipAddr & "\n" & status.replace("\n", "").replace("  ", "")

proc checkIPwTorServer*(): string =
  #[
    Check current public IP using https://check.torproject.org/ 
  ]#
  const
    target = "https://check.torproject.org/"
  var
    client = newHttpClient()
  
  let resp = client.get(target)
  return parseIPbyTorServer(resp.body)