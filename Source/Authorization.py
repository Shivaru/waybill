import mechanicalsoup
import urllib.parse

browser = mechanicalsoup.StatefulBrowser()
browser.open("http://hosting.wialon.com/login.html")
browser.select_form('form[action="oauth.html"]')
browser["login"] = "20315"
browser["passw"] = "123654"
browser.submit_selected()
auth_url = browser.get_url()
auth_query = auth_url.replace("http://hosting.wialon.com/login.html?","")
auth_query = urllib.parse.parse_qs(auth_query)
access_token = auth_query["access_token"][0]
print(access_token)




