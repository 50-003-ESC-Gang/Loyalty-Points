reset-db:
	rake db:drop
	rake db:create
	rake db:migrate
	rake db:seed

reset-heroku-db:
	heroku restart; heroku pg:reset DATABASE --confirm esc-loyalty-program; heroku run rake db:migrate heroku run rake db:seed



rebase-master:
	git checkout master
	git pull origin master
	git checkout -
	git rebase master