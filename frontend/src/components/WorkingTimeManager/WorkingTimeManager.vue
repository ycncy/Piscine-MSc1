<template>
  <div class="p-4 m-auto gap-4 justify-center items-center h-full w-[90%]">
    <div class="p-8 flex flex-col gap-16 h-full bg-[#242424]">
      <div>
        <WorkingTimeEditor :working_times="this.workingtimes" :current_user="this.current_user"/>
      </div>
    </div>
  </div>
</template>

<script>
import WorkingTimes from "@/components/WorkingTimeManager/WorkingTimes.vue";
import WorkingTimeEditor from "@/components/WorkingTimeManager/WorkingTimeEditor.vue"
import {users_service} from "@/services/users.service";
import {working_time_service} from "@/services/workingtimes.service";

export default {
  name: "WorkingTimeManager",
  components: {WorkingTimes, WorkingTimeEditor},
  data() {
    return {
      workingtimes: [],
      current_user: undefined,
      editor_mode_boolean: false
    };
  },
  methods: {
    getWorkingtimes: function () {
      users_service.get_user_by_id(this.$route.params.userID).then((response) => {
        this.current_user = response.data
      })

      working_time_service.get_working_times_by_id(this.$route.params.userID)
          .then((result) => {
            this.workingtimes = result.data;
          });
    }
  },
  created() {
    this.getWorkingtimes();
  },
}
</script>