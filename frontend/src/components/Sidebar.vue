<template>
    <div class="hidden bg-[#161717] min-h-screen w-16 sm:flex flex-col justify-start items-center gap-24">
      <img src="../assets/logo.png" class="invert" alt="logo"/>
      <ul v-if="JSON.parse(authentication_service.get_user()).role !== 'employee'" class="flex flex-col justify-around gap-12">
        <li>
          <router-link class="flex gap-6 items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group" :to="'/dashboard'">
            <svg class="fill-white w-6 h-6" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><path d="M64 64c0-17.7-14.3-32-32-32S0 46.3 0 64V400c0 44.2 35.8 80 80 80H480c17.7 0 32-14.3 32-32s-14.3-32-32-32H80c-8.8 0-16-7.2-16-16V64zm406.6 86.6c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L320 210.7l-57.4-57.4c-12.5-12.5-32.8-12.5-45.3 0l-112 112c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L240 221.3l57.4 57.4c12.5 12.5 32.8 12.5 45.3 0l128-128z"/></svg>
          </router-link>
        </li>
      </ul>
      <ul class="flex flex-col justify-around gap-12">
        <li>
          <router-link class="flex gap-6 items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group" to="/dashboard/profile/workingTimes">
            <svg class="fill-white h-6 w-6" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 512 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M0 96C0 60.7 28.7 32 64 32H448c35.3 0 64 28.7 64 64V416c0 35.3-28.7 64-64 64H64c-35.3 0-64-28.7-64-64V96zm64 64V416H224V160H64zm384 0H288V416H448V160z"/></svg>
          </router-link>
        </li>
        <li>
          <router-link class="flex gap-6 items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group" to="/dashboard/profile/chartManager">
            <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 22 21">
              <path d="M16.975 11H10V4.025a1 1 0 0 0-1.066-.998 8.5 8.5 0 1 0 9.039 9.039.999.999 0 0 0-1-1.066h.002Z"/>
              <path d="M12.5 0c-.157 0-.311.01-.565.027A1 1 0 0 0 11 1.02V10h8.975a1 1 0 0 0 1-.935c.013-.188.028-.374.028-.565A8.51 8.51 0 0 0 12.5 0Z"/>
            </svg>
          </router-link>
        </li>
        <li>
          <router-link class="flex gap-6 items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group" to="/dashboard/profile">
            <svg class="fill-white h-6 w-6" xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 576 512"><!--! Font Awesome Free 6.4.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M64 32C28.7 32 0 60.7 0 96V416c0 35.3 28.7 64 64 64H512c35.3 0 64-28.7 64-64V96c0-35.3-28.7-64-64-64H64zm80 256h64c44.2 0 80 35.8 80 80c0 8.8-7.2 16-16 16H80c-8.8 0-16-7.2-16-16c0-44.2 35.8-80 80-80zm-32-96a64 64 0 1 1 128 0 64 64 0 1 1 -128 0zm256-32H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16zm0 64H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16zm0 64H496c8.8 0 16 7.2 16 16s-7.2 16-16 16H368c-8.8 0-16-7.2-16-16s7.2-16 16-16z"/></svg>
          </router-link>
        </li>
      </ul>

      <div class="flex flex-col gap-4">
        <Clocks/>
        <Logout/>
      </div>
    </div>


    <div class="fixed bottom-0 left-0 z-50 w-full h-16 bg-white border-t border-gray-200 dark:bg-gray-700 dark:border-gray-600 sm:hidden">
    <div class="grid h-full max-w-lg grid-cols-3 mx-auto font-medium">
        <button type="button" class="inline-flex flex-col items-center justify-center px-5 border-r border-gray-200 hover:bg-gray-50 dark:hover:bg-gray-800 group dark:border-gray-600" >
          <router-link class="flex gap-6 items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group" to="/dashboard/profile/workingTimes">
            <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 448 512" fill="currentColor">
              <path d="M96 32V64H48C21.5 64 0 85.5 0 112v48H448V112c0-26.5-21.5-48-48-48H352V32c0-17.7-14.3-32-32-32s-32 14.3-32 32V64H160V32c0-17.7-14.3-32-32-32S96 14.3 96 32zM448 192H0V464c0 26.5 21.5 48 48 48H400c26.5 0 48-21.5 48-48V192z"/>
            </svg>
          </router-link>
            <span class="text-sm text-gray-500 dark:text-gray-400 group-hover:text-blue-600 dark:group-hover:text-blue-500">Calendar</span>
        </button>

        <button type="button" class="inline-flex flex-col items-center justify-center px-5 border-r border-gray-200 hover:bg-gray-50 dark:hover:bg-gray-800 group dark:border-gray-600" >
          <router-link class="flex gap-6 items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group" :to="'/dashboard/clocking' + this.$route.params.userID">
            <svg xmlns="http://www.w3.org/2000/svg" height="1em" viewBox="0 0 384 512" fill="currentColor">
              <path d="M32 0C14.3 0 0 14.3 0 32S14.3 64 32 64V75c0 42.4 16.9 83.1 46.9 113.1L146.7 256 78.9 323.9C48.9 353.9 32 394.6 32 437v11c-17.7 0-32 14.3-32 32s14.3 32 32 32H64 320h32c17.7 0 32-14.3 32-32s-14.3-32-32-32V437c0-42.4-16.9-83.1-46.9-113.1L237.3 256l67.9-67.9c30-30 46.9-70.7 46.9-113.1V64c17.7 0 32-14.3 32-32s-14.3-32-32-32H320 64 32zM288 437v11H96V437c0-25.5 10.1-49.9 28.1-67.9L192 301.3l67.9 67.9c18 18 28.1 42.4 28.1 67.9z"/></svg>
          </router-link>
          <span class="text-sm text-gray-500 dark:text-gray-400 group-hover:text-blue-600 dark:group-hover:text-blue-500">Clock</span>

        </button>

        <button type="button" class="inline-flex flex-col items-center justify-center px-5 border-gray-200 hover:bg-gray-50 dark:hover:bg-gray-800 group border-x dark:border-gray-600">
          <router-link class="flex gap-6 items-center p-2 text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700 group" to="/dashboard/profile">
            <svg xmlns="http://www.w3.org/2000/svg" height="1em" fill="currentColor" viewBox="0 0 448 512" >
              <path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"/>
            </svg>
          </router-link>
            <span class="text-sm text-gray-500 dark:text-gray-400 group-hover:text-blue-600 dark:group-hover:text-blue-500">Profile</span>
        </button>
        </div>
    </div>


</template>

<script>
import {authentication_service} from "@/services/authentication.service";
import Clocks from "@/components/Clocks.vue";
import Logout from "@/components/Authentication/Logout.vue";

export default {
  name: 'Sidebar',
  components: {Logout, Clocks},
  computed: {
    authentication_service() {
      return authentication_service
    }
  }
};
</script>
