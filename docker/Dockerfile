# Serves pre-built static assets from Nuxt
FROM nginx:alpine

# Cloud Run listens on $PORT; we’ll bind NGINX to 8080
ENV PORT=8080

# NGINX site config (cache headers + SPA fallback + gzip)
COPY infra/nginx/ui.conf /etc/nginx/conf.d/default.conf

# Copy the generated Nuxt output into the web root at build time.
# We pass NUXT_OUTPUT as a build-arg from the workflow (default: .output/public)
ARG NUXT_OUTPUT=dist
COPY ${NUXT_OUTPUT}/ /usr/share/nginx/html/

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
