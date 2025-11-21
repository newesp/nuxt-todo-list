<template>
  <div class="flex items-center justify-center min-h-[calc(100vh-8rem)]">
    <div class="w-full max-w-md glass-strong rounded-3xl p-8 shadow-2xl fade-in">
      <!-- Header -->
      <div class="text-center mb-8">
        <div class="w-16 h-16 mx-auto mb-4 rounded-full bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center">
          <UIcon name="i-heroicons-check-circle-solid" class="w-8 h-8 text-white" />
        </div>
        <h1 class="text-3xl font-bold bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">
          歡迎使用 Todo AI
        </h1>
        <p class="mt-2 text-sm text-gray-600 dark:text-gray-400">
          使用 Google 帳號快速登入
        </p>
      </div>

      <!-- Google Sign In Button -->
      <button
        @click="signInWithGoogle"
        :disabled="loading"
        class="w-full bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-200 border-2 border-gray-300 dark:border-gray-600 rounded-2xl px-6 py-4 font-semibold flex items-center justify-center gap-3 hover:bg-gray-50 dark:hover:bg-gray-700 transition-all hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed shadow-md"
      >
        <svg v-if="!loading" class="w-6 h-6" viewBox="0 0 24 24">
          <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
          <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
          <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
          <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
        </svg>
        <span v-if="loading" class="inline-block w-5 h-5 border-2 border-gray-400 border-t-transparent rounded-full animate-spin"></span>
        <span class="text-lg">{{ loading ? '登入中...' : '使用 Google 登入' }}</span>
      </button>

      <!-- Info Text -->
      <div class="mt-6 text-center">
        <p class="text-xs text-gray-500 dark:text-gray-500">
          點擊登入即表示您同意我們的服務條款和隱私政策
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
const supabase = useSupabaseClient()
const toast = useToast()
const router = useRouter()
const loading = ref(false)
const checking = ref(true)

let authSubscription: any = null

// Check session on mount and handle OAuth callback
onMounted(async () => {
  console.log('Login page mounted, checking session...')
  
  // Check if this is an OAuth callback
  const urlParams = new URLSearchParams(window.location.search)
  const hashParams = new URLSearchParams(window.location.hash.substring(1))
  const code = urlParams.get('code')
  const accessToken = hashParams.get('access_token')
  const error = urlParams.get('error') || hashParams.get('error')
  
  console.log('URL params:', { code: !!code, accessToken: !!accessToken, error })
  
  if (error) {
    console.error('OAuth error:', error)
    toast.add({ 
      title: '登入失敗', 
      description: error, 
      color: 'error' 
    })
    checking.value = false
    return
  }
  
  // If we have a code, wait for Supabase to exchange it
  if (code || accessToken) {
    console.log('OAuth callback detected, waiting for session exchange...')
    
    // Wait for Supabase to process the OAuth callback
    // Try multiple times with increasing delays
    let session = null
    for (let i = 0; i < 5; i++) {
      await new Promise(resolve => setTimeout(resolve, 500 * (i + 1)))
      const { data } = await supabase.auth.getSession()
      console.log(`Session check attempt ${i + 1}:`, !!data.session)
      if (data.session) {
        session = data.session
        break
      }
    }
    
    if (session) {
      console.log('Session established, redirecting to home...')
      toast.add({ 
        title: '登入成功', 
        description: '歡迎回來！', 
        color: 'success' 
      })
      checking.value = false
      console.log('Forcing redirect with window.location.href')
      window.location.href = '/'
      return
    } else {
      console.error('Failed to establish session after OAuth callback')
      toast.add({ 
        title: '登入失敗', 
        description: '無法建立登入會話，請重試', 
        color: 'error' 
      })
      checking.value = false
      return
    }
  }
  
  // Regular session check (not OAuth callback)
  const { data: { session } } = await supabase.auth.getSession()
  
  console.log('Regular session check:', !!session)
  
  if (session) {
    console.log('User is already logged in, redirecting to home...')
    toast.add({ 
      title: '已登入', 
      description: '歡迎回來！', 
      color: 'success' 
    })
    checking.value = false
    console.log('Already logged in, forcing redirect')
    window.location.href = '/'
    return
  }
  
  checking.value = false
  
  // Set up auth state listener for future changes
  const { data: { subscription } } = supabase.auth.onAuthStateChange(async (event, session) => {
    console.log('Auth state changed:', event, !!session)
    
    if (event === 'SIGNED_IN' && session) {
      toast.add({ 
        title: '登入成功', 
        description: '歡迎回來！', 
        color: 'success' 
      })
      console.log('Auth state changed to SIGNED_IN, forcing redirect')
      window.location.href = '/'
    }
  })
  
  authSubscription = subscription
})

// Cleanup subscription on unmount
onUnmounted(() => {
  if (authSubscription) {
    authSubscription.unsubscribe()
  }
})

const signInWithGoogle = async () => {
  loading.value = true
  try {
    // Get the current URL dynamically to support any domain
    const currentUrl = window.location.href.split('?')[0]
    
    const { data, error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: currentUrl,
        queryParams: {
          access_type: 'offline',
          prompt: 'consent',
        }
      }
    })
    
    if (error) throw error
    
    console.log('OAuth redirect initiated')
    // OAuth will redirect automatically
  } catch (error: any) {
    console.error('OAuth error:', error)
    toast.add({ 
      title: '登入失敗', 
      description: error.message || '無法連接到 Google 登入服務', 
      color: 'error' 
    })
    loading.value = false
  }
}
</script>
