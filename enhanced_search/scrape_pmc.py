
from requests_html import HTMLSession
import requests
from requests.exceptions import ConnectionError

sess = HTMLSession()

headers= {'user-agent': 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36 Edg/100.0.1185.44'}



pmcs = ["PMC8692454"]

for pmc in pmcs:

	url = f"https://www.ncbi.nlm.nih.gov/pmc/articles/{pmc}/"
	print(url)

	res = sess.get(url, headers=headers, timeout=5)

	print(res)

	print(res.html)

	page = res.html

	print(page.text)

