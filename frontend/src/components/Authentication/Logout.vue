<script>
import {authentication_service} from "@/services/authentication.service";

export default {
  name: "Logout",
  methods: {
    async logout() {
      await authentication_service.logout();

      authentication_service.delete_user();
      authentication_service.delete_token();

      this.$router.push("/login")
    }
  }
}
</script>

<template>
  <button @click="logout" class="text-gray-300 bg-[#161717] rounded-full p-5 w-8 h-8 flex items-center justify-center">
    <span class="material-symbols-outlined"> logout </span>
  </button>
</template>