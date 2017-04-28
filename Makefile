check: build
	bundle exec htmlproofer ./_site/ --only-4xx

build:
	bundle exec jekyll build
