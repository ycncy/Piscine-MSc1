<script setup>

</script>

<template>
  <section class="flex items-center h-1/2 bg-[#242424]">
    <div class="container flex flex-col items-center">
      <div class="flex flex-col gap-6 text-center">
        <h2 class="font-extrabold text-9xl text-gray-400">
          <span class="sr-only">Error</span>404
        </h2>
        <p class="text-2xl md:text-3xl text-gray-400">Sorry, we couldn't find this page.</p>
        <router-link class="px-8 py-4 text-xl font-semibold rounded bg-[#161717] text-gray-50 hover:text-gray-200" to="/dashboard">
          Go to dashboard
        </router-link>
       </div>
    </div>
  </section>
</template>

<style scoped>

</style>