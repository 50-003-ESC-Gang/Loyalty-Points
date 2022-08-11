require 'rubygems'
require 'selenium-webdriver'
service = Selenium::WebDriver::Service.chrome(path: 'C:/Users/LENOVO/Desktop/chromedriver.exe')


options = Selenium::WebDriver::Options.chrome


driver = Selenium::WebDriver.for :chrome, service: service, capabilities: options


#local port server
driver.get('http://127.0.0.1:3000')

emailInput = driver.find_element(name: 'user[email]')
passInput = driver.find_element(name: 'user[password]')

sleep 3

emailInput.send_keys "3@gmail.com"
emailInput.submit

passInput.send_keys "123456"
passInput.submit
sleep 5


trans = driver.find_element(name: 'transactions')
trans.click
sleep 8


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

transP = driver.find_element(name: "transP")
transP.click
sleep 5

inExchange = driver.find_element(name: 'loyalty_program_datum[in_points]')
inExchange.send_keys "30"
sleep 5


subExchange = driver.find_element(name: "commit")
subExchange.click
sleep 3

trans = driver.find_element(name: 'transactions')
trans.click
sleep 7

ex = driver.find_element(name: 'exchange')
ex.click
sleep 7

signOut = driver.find_element(name: "sign_out")
signOut.click
sleep 3


#Show admin can change conversion rate

emailInput = driver.find_element(name: 'user[email]')
passInput = driver.find_element(name: 'user[password]')
sleep 1

emailInput.send_keys "admin@gmail.com"
emailInput.submit

passInput.send_keys "123456"
passInput.submit
sleep 3

loyaltyP = driver.find_element(name: 'loyalty_programs')
loyaltyP.click
sleep 5

linkAcc = driver.find_element(name: 'link_account')
linkAcc.click
sleep 5

convInput = driver.find_element(name: "conversion_rate")
convInput.send_keys 0.7
sleep 5

convInput.submit
sleep 7


# #Valid input
# linkMember = driver.find_element(name: "membership_id")
# linkMember.send_keys 12345678

# buttonLM = driver.find_element(name: "submit_memID")
# buttonLM.click


# #Invalid input
# linkMember = driver.find_element(name: "membership_id")
# linkMember.send_keys "1amno1"
# linkMember.submit

# buttonLM = driver.find_element(name: "submit_memID")
# buttonLM.click





