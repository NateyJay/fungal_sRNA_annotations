
from requests_html import HTMLSession
import requests
from requests.exceptions import ConnectionError

import sys
from bs4 import BeautifulSoup
from selenium import webdriver


url = 'https://onlinelibrary.wiley.com/doi/10.1111/pce.14564'

dr = webdriver.Chrome()
dr.get(url)
bs = BeautifulSoup(dr.page_source,"lxml")

print(bs.prettify())

sys.exit()

sess = HTMLSession()

headers= {'user-agent': 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36 Edg/100.0.1185.44'}


urls = ['https://onlinelibrary.wiley.com/doi/10.1111/pce.14564'
]

for url in urls:

	# url = f"https://www.ncbi.nlm.nih.gov/pmc/articles/{pmc}/"
	print(url)

	res = sess.get(url, headers=headers, timeout=5)

	print(res)

	print(res.html)

	page = res.html

	print(page.text)

