// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  srcDir: 'app',
  css: ['~/assets/css/style.css'],
  modules: ['@nuxtjs/supabase', '@nuxt/ui'],
  supabase: {
    redirectOptions: {
      login: '/login',
      callback: '/confirm',
      exclude: ['/'],
    }
  }
})
