<template>
  <section class="bg-[#161717]">
    <div class="flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0">
      <a href="#" class="flex flex-col items-center mb-6 text-2xl font-semibold text-white">
        <img class="w-16 h-16 mr-2" src="@/assets/logo.png" alt="logo">
        Time Manager
      </a>
      <div class="w-full rounded-lg shadow border md:mt-0 sm:max-w-md xl:p-0 bg-[#232424] border-gray-400">
        <div class="p-6 space-y-4 md:space-y-6 sm:p-8 text-white">
          <h1 class="text-xl font-bold leading-tight tracking-tight md:text-2xl">
            Sign in to your account
          </h1>
          <p class="text-red-700" v-if="error">{{ this.error }}</p>
          <form @submit.prevent="login" class="space-y-4 md:space-y-6">
            <div>
              <label for="email" class="block mb-2 text-sm font-medium">Your email</label>
              <input v-model="email" type="email" name="email" id="email" class="border sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 bg-[#303131] border-gray-600 placeholder-gray-400 text-white focus:ring-blue-500 focus:border-blue-500" placeholder="name@company.com" required>
            </div>
            <div>
              <label for="password" class="block mb-2 text-sm font-medium">Password</label>
              <input v-model="password" type="password" name="password" id="password" placeholder="••••••••" class="border sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 bg-[#303131] border-gray-600 placeholder-gray-400 text-white focus:ring-blue-500 focus:border-blue-500" required>
            </div>
            <button type="submit" class="w-full text-white bg-gray-400 hover:bg-[#161717] focus:ring-4 font-medium rounded-lg text-sm px-5 py-2.5 text-center bg-primary-600 duration-150 hover:bg-primary-700 focus:ring-gray-500">Sign in</button>
          </form>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import {authentication_service} from "@/services/authentication.service";
import axios from "axios";

export default {
  data() {
    return {
      email: '',
      password: '',
      error: undefined
    };
  },
  methods: {
    async login() {
      const response = await authentication_service.login(
          this.email,
          this.password
      );

      if (response.status_code === 200) {
        this.$router.push("/");
      } else {
        this.error = response.error;
      }
    },
    async test() {
      const resp = await axios.get("http://localhost:4000/api/users/all", {withCredentials: true});

      console.log(resp)
    }
  },
};
</script>
