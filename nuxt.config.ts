// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: "2025-07-15",
  devtools: { enabled: true },
  css: ["~/assets/css/main.css"],

  nitro: {
    output: {
      publicDir: "dist", // static site goes here -> docker/dist
    },
  },

  modules: [
    "@nuxt/eslint",
    "@nuxt/test-utils",
    "@nuxt/fonts",
    "@nuxt/content",
    "@nuxt/ui",
  ],
});
