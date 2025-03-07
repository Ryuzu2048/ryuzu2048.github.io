BASE_URL := https://ryuzu2048.github.io
OUTPUT := docs/sitemap.xml

HTML_FILES := $(shell find docs -type f -name '*.html')

.PHONY: all clean

all: $(OUTPUT)

$(OUTPUT): $(HTML_FILES)
	@echo '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' > $(OUTPUT)
	@echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">' >> $(OUTPUT)
	@for file in $(HTML_FILES); do \
		url=$$(echo $$file | sed 's|docs/||'); \
		lastmod=$$(date -r $$file +"%Y-%m-%dT%H:%M:%S%z" | sed 's/\(.\{22\}\)/\1:/'); \
		echo "  <url>" >> $(OUTPUT); \
		echo "    <loc>$(BASE_URL)/$$url</loc>" >> $(OUTPUT); \
		echo "    <lastmod>$$lastmod</lastmod>" >> $(OUTPUT); \
		echo "  </url>" >> $(OUTPUT); \
	done
	@echo '</urlset>' >> $(OUTPUT)
	@echo "Sitemap generated at $(OUTPUT)"

clean:
	rm -f $(OUTPUT)
