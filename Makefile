generate_key:
	ssh-keygen -f ./key -P ""

init:
	terraform init

plan:
	terraform plan

apply:
	terraform apply --auto-approve

destroy:
	terraform destroy --auto-approve

install:
	make generate-key > generate-key.log
	make init > init.log

deploy:
	make plan > plan.log
	make apply > apply.log

uninstall:
	make destroy > destroy.log

magic:
	make install
	make deploy

save:
	git add .
	git commit -a -m "Save"
	git push
