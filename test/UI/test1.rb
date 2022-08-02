require 'rubygems'
require 'selenium-webdriver'
service = Selenium::WebDriver::Service.chrome(path: 'C:/Users/LENOVO/Desktop/chromedriver.exe')


options = Selenium::WebDriver::Options.chrome


driver = Selenium::WebDriver.for :chrome, service: service, capabilities: options

driver.get('http://127.0.0.1:3000')

emailInput = driver.find_element(name: 'user[email]')
passInput = driver.find_element(name: 'user[password]')

emailInput.send_keys "3@gmail.com"
emailInput.submit

passInput.send_keys "123456"
passInput.submit
sleep 5


trans = driver.find_element(name: 'trans')
trans.click
sleep 8

driver.get('http://127.0.0.1:3000')
sleep 3

# go to exchange point page
ex = driver.find_element(name: 'exchange')
ex.click
sleep 5

#find transfer points
# transP = driver.find_element(name: "trans9")
# # driver.execute_script("arguments[0].click();", transP)
# transP.click()

# transP = driver.find_element(class: 'trans')
# transP.click

driver.get('http://127.0.0.1:3000/loyalty_program_data/19/edit')
sleep 3

inExchange = driver.find_element(name: 'loyalty_program_datum[in_points]')
inExchange.send_keys "12"
sleep 3

subExchange = driver.find_element(name: "commit")
subExchange.click
sleep 3

driver.get('http://127.0.0.1:3000/loyalty_program_data')
sleep 3


#show final transaction and see that there is a new transaction being created upon points transfer
driver.get('http://127.0.0.1:3000/transactions')
sleep 8




# button = driver.find_element(name: 'commit')
# driver.quit

