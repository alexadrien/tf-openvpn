generate_key:
	rm key
	rm key.pub
	ssh-keygen -f ./key -P "" -N ""

init:
	terraform init

plan:
	terraform plan

apply:
	terraform apply --auto-approve

destroy:
	terraform destroy --auto-approve

install:
	make generate_key > generate_key.log
	make init > init.log

deploy:
	make plan > plan.log
	make apply > apply.log

display_information:
	terraform output connect
	echo "username : openvpn"
	echo "password : openvpn"

uninstall:
	make destroy > destroy.log

magic:
	make install
	make deploy
	make display_information

save:
	git add .
	git commit -a -m "Save"
	git push

