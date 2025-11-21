<template>
  <div>
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </div>
</template>

<script setup>
// Fix FOUC by adding 'loaded' class to body after mount
onMounted(() => {
  // Use requestAnimationFrame to ensure next paint includes the class
  // Increased delay slightly to ensure CSS is fully parsed
  setTimeout(() => {
    requestAnimationFrame(() => {
      document.body.classList.add('loaded')
      document.documentElement.classList.add('loaded')
    })
  }, 200)
})
</script>
