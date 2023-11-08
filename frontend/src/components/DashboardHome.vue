<template>
  <div v-if="this.no_params" class=" hidden sm:flex-col h-1/4 justify-center">
    <h1 class="sm:hidden text-gray-400 text-4xl w-full h-1/4 flex justify-center items-center">
      Welcome to Time Manager Dashboard
    </h1>

    <h2 class="text-gray-400 text-2xl w-full h-1/4 flex justify-center items-center">
      Please select a user with the search-bar to start using it.
    </h2>
  </div>
</template>

<script>
import Loader from "@/components/Loader.vue";

export default {
  name: "DashboardHome",
  components: {Loader},
  data() {
    return {
      no_params: false
    }
  },
  async mounted() {
    if (Object.keys(this.$route.params).length === 0) {
      this.no_params = true;
    }
  }
}

</script>