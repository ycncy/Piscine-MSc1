<template>

  <div class="p-4 m-auto gap-4 justify-center items-center h-full w-[90%]">
    <div class="p-8 rounded-3xl flex flex-col gap-16 shadow-md h-full bg-white border border-blue">
      <div class="flex flex-row justify-around">
        <button class="ui button big" :class="[isActive ? 'green' : 'red']" @click="toggle">{{isActive ? 'ON' : 'OFF'}}</button>
      </div>
      <div class="flex flex-col gap-5">
        <table class="rounded-xl shadow-md text-l text-left text-gray-500 bg-gray-50">
          <thead class="text-gray-700 uppercase border-gray-200 border-b">
          <tr>
            <th scope="col" class="px-6 py-3">Username</th>
            <th scope="col" class="px-6 py-3">Time</th>
            <th scope="col" class="px-6 py-3">Status</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(clocks, i) in clocks" :key="i"
              class="">
            <td class="px-6 py-6">{{ current_user.username }}</td>
            <td class="px-6 py-6">{{ clocks.time }}</td>
            <td class="px-6 py-6">{{ clocks.status }}</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

</template>

<script >
import {clocks_service} from "@/services/clocks.service";
import {users_service} from "@/services/users.service";

    export default {
          data() {
        return {
          isActive: false,
          clocks: [],
          current_user: undefined
        };
      },
      methods: {
        getclocks: function () {
          users_service.get_user_by_id(this.$route.params.userID).then((response) => {
            this.current_user = response.data
          })

          clocks_service.get_clock_by_user_id(this.$route.params.userID).then((result) => {
            this.clocks = result.data;
          });

        },
        async toggle() {
          this.isActive = this.isActive ? false : true;
          if(this.isActive == true){
            const response = await clocks_service.create_clocking_time(
              new Date(),
              this.$route.params.userID,
              true
            );

            switch (response.status_code) {
              case 201:
                this.getclocks();
                break;
              case 422:
                this.error = "Non-valid email format";
                break;
              case 403:
                this.error = "User already exists";
            }
          }else{
            const response = await clocks_service.create_clocking_time(
              new Date(),
              this.$route.params.userID,
              false
            );

            switch (response.status_code) {
              case 201:
                this.getclocks();
                break;
              case 422:
                this.error = "Non-valid email format";
                break;
              case 403:
                this.error = "User already exists";
            }
          }
        },
        startDateTimer() {
          this.timer = setInterval(() => {
            this.date = new Date();
          }, 1000);
        },
        clockIn() {
          this.startDateTimer();
        },
        refresh() {
          this.date = new Date();
        },
        clocks() {
          this.$router.push({ name: "Clocks" });
        },
        },
        created() {
          this.getclocks();
        },
    }
</script>
