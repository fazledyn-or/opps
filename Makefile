.PHONY: test
test: pep8 clean
	python runtests.py -s

.PHONY: tox-toxtest
tox-test: environment
	@tox

.PHONY: install
install:
	python setup.py develop

.PHONY: pep8
pep8:
	@flake8 opps --ignore=F403,F401 --exclude=migrations,postgresql_psycopg2

.PHONY: sdist
sdist: test
	@python setup.py sdist upload

.PHONY: clean
clean:
	@find ./ -name '*.pyc' -exec rm -f {} \;
	@find ./ -name 'Thumbs.db' -exec rm -f {} \;
	@find ./ -name '*~' -exec rm -f {} 	\;

.PHONY: makemessages
makemessages:
	@sh scripts/makemassages.sh

.PHONY: compilemessages
compilemessages:
	@sh scripts/compilemessages.sh

.PHONY: tx
tx:
	@sh scripts/tx.sh

.PHONY: txpush
txpush:
	tx push --scriptsource --translations

.PHONY: txpull
txpull:
	tx pull -a

.PHONY: doc-github
doc-github:
	@mkdocs build
	@ghp-import site
	@git push origin gh-pages

.PHONY: doc-serve
doc-serve:
	@mkdocs serve
