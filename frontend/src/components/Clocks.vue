<template>

  <div class="p-4 m-auto gap-4 justify-center items-center h-full w-[90%]">
    <div class="p-8 rounded-3xl flex flex-col gap-16 shadow-md h-full bg-white border border-blue">
      <div class="flex flex-row justify-around">
        <button class="ui button big" :class="[isActive ? 'green' : 'red']" @click="toggle">{{isActive ? 'ON' : 'OFF'}}</button>
      </div>
    </div>
  </div>

</template>

<script >
import {clocks_service} from "@/services/clocks.service";
import {users_service} from "@/services/users.service";
import {working_time_service} from "@/services/workingtimes.service";


    export default {
          data() {
        return {
          isActive: false,
          clocks: [],
          current_user: undefined
        };
      },
      methods: {
        async registerClocks(isActive,get_clocks){
          if(isActive == true){
            if(get_clocks == 0){
              const response = await clocks_service.create_clocking_time(
                new Date(),
                this.$route.params.userID,
                true
              );
              switch (response.status_code) {
                case 201:
                  console.log('success');
                  break;
                case 422:
                  this.error = "Error";
                  break;
                case 403:
                  this.error = "Error";
              }
            }else{
              const retour = await clocks_service.update_clock(
                this.$route.params.userID,
                new Date(),
                true
              )
              switch (retour.status_code) {
                case 200:
                  console.log('success');
                  break;
                case 403:
                  this.error = "Update failed";
              }
            }
            
          }else{
            const end_time = new Date();
            const get_start_time = await clocks_service.get_clock_by_user_id(
            this.$route.params.userID
            );
            const ret = working_time_service.create_working_time(
                this.$route.params.userID,
                get_start_time.data[0].time,
                end_time,
                true
            );
            switch (ret.status_code) {
              case 201:
                console.log('success')
                break;
              case 403:
                this.error = "Working_time already exists";
            }
            const resp = await clocks_service.update_clock(
                this.$route.params.userID,
                end_time,
                false
              )
              switch (resp.status_code) {
                case 200:
                  console.log('success');
                  break;
                case 403:
                  this.error = "Update failed";
              }
          }
        },
        async toggle() {
          this.isActive = this.isActive ? false : true;
          const check_clock = await clocks_service.check_clock(this.$route.params.userID, this.isActive,new Date())

          // const get_clocks = await clocks_service.get_clock_by_user_id(
          //   this.$route.params.userID
          // );
          // switch (get_clocks.status_code) {
          //   case 200:
          //   this.registerClocks(this.isActive,get_clocks.data.length);
          //     break;
          //   case 404:
          //   this.registerClocks(this.isActive,0);
          // }

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
    }
</script>
