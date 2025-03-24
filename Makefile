p1:
	@cd p1 && vagrant up

p2:
	@cd p2 && vagrant up

p3:
	@cd p3 && sh ./scripts/setup.sh && sh ./scripts/argocd.sh

bonus:
	@cd bonus && sh ./scripts/setup.sh && sleep 30 && sh ./scripts/argocd.sh && sh ./scripts/gitlab.sh

stop:
	@docker stop $$(docker ps -aq)

clean:
	@docker system prune -af

fclean: stop clean

.PHONY: p1 p2 p3 stop clean fclean