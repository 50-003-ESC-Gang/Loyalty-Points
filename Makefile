reset-db:
	rake db:drop
	rake db:create
	rake db:migrate
	rake db:seed

rebase-master:
	git checkout master
	git pull origin master
	git checkout -
	git rebase master