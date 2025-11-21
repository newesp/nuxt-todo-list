<template>
  <div class="min-h-screen">
    <!-- Apple-Style Header with Glassmorphism -->
    <header class="glass-strong sticky top-0 z-50 border-b border-white/20 dark:border-white/10">
      <div class="container mx-auto px-6 h-16 flex items-center justify-between">
        <div class="flex items-center gap-3">
          <div class="w-8 h-8 rounded-full bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center">
            <UIcon name="i-heroicons-check-circle-solid" class="w-5 h-5 text-white" />
          </div>
          <span class="text-xl font-semibold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
            Todo AI
          </span>
        </div>
        
        <div class="flex items-center gap-2">
          <button
            @click="isDark = !isDark"
            class="w-10 h-10 rounded-full glass hover:bg-white/50 dark:hover:bg-white/10 flex items-center justify-center transition-all"
          >
            <UIcon :name="isDark ? 'i-heroicons-sun' : 'i-heroicons-moon'" class="w-5 h-5" />
          </button>
          
          <button
            v-if="user"
            @click="logout"
            class="px-4 py-2 rounded-full glass hover:bg-white/50 dark:hover:bg-white/10 font-medium text-sm transition-all"
          >
            登出
          </button>
        </div>
      </div>
    </header>

    <!-- Main Content -->
    <main class="container mx-auto px-6 py-12">
      <slot />
    </main>
  </div>
</template>

<script setup lang="ts">
const user = useSupabaseUser()
const supabase = useSupabaseClient()
const colorMode = useColorMode()

const isDark = computed({
  get() {
    return colorMode.value === 'dark'
  },
  set() {
    colorMode.preference = colorMode.value === 'dark' ? 'light' : 'dark'
  }
})

const logout = async () => {
  await supabase.auth.signOut()
  window.location.href = '/login'
}
</script>
