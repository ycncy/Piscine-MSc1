<template>
  <div v-if="this.no_params" class="flex flex-col h-1/4 justify-center">
    <h1 class="text-gray-400 text-4xl w-full h-1/4 flex justify-center items-center">
      Welcome to Time Manager Dashboard !
    </h1>

    <h2 class="text-gray-400 text-2xl w-full h-1/4 flex justify-center items-center">
      Please select a user with the search-bar to start using it.
    </h2>
  </div>
  <div v-else-if="!this.current_user">
    <Loader class="w-full flex py-16 justify-center"/>
  </div>
  <div v-else class="flex flex-col h-1/4 justify-center items-center">
    <h1 class="text-gray-400 text-3xl" v-if="this.current_user">You have selected user : {{ this.current_user.username }}</h1>
    <section v-else-if="!this.invalid_user" class="flex items-center h-1/2 bg-[#242424]">
      <div class="container flex flex-col items-center">
        <div class="flex flex-col gap-6 text-center">
          <h2 class="font-extrabold text-9xl text-gray-400">
            <span class="sr-only">Error</span>404
          </h2>
          <p class="text-2xl md:text-3xl dark:text-gray-400">No user selected, please select a real user in the list</p>
        </div>
      </div>
    </section>
    <section v-if="this.invalid_user" class="flex items-center h-1/2 bg-[#242424]">
      <div class="container flex flex-col items-center">
        <div class="flex flex-col gap-6 text-center">
          <h2 class="font-extrabold text-9xl text-gray-400">
            <span class="sr-only">Error</span>404
          </h2>
          <p class="text-2xl md:text-3xl dark:text-gray-400">Invalid user, please select a real user in the list</p>
        </div>
      </div>
    </section>
  </div>
</template>

<script>

import {users_service} from "@/services/users.service";
import Loader from "@/components/Loader.vue";

export default {
  name: "DashboardHome",
  components: {Loader},
  data() {
    return {
      current_user: undefined,
      invalid_user: false,
      no_params: false
    }
  },
  async mounted() {
    if (Object.keys(this.$route.params).length === 0) {
      this.no_params = true;
    } else {
      const user_id = this.$route.params.userID;

      if (!isNaN(parseInt(user_id))) {
        await users_service.get_user_by_id(user_id).then(response => {
          if (response.status_code === 404) this.invalid_user = true
          if (response.status_code === 500) this.invalid_user = true
          this.current_user = response.data;
        }).catch(() => {
        })
      }
    }
  }
}

</script>