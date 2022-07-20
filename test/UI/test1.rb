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

# go to exchange point page
trans = driver.find_element(name: 'exchange')
trans.click
sleep 5

#find transfer points
transP = driver.find_element(name: "9")
transP.click

sleep 3

inExchange = driver.find_element(name: 'loyalty_program_datum[in_points]')
inExchange.send_keys "245"

sleep 3



# button = driver.find_element(name: 'commit')





puts driver.title

# driver.quit

puts  "Facebook webpage loaded"
