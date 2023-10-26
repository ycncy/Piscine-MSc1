<template>
    <Line/>
</template>
<script setup>
import { get_working_times_by_id, get_all_working_times } from "@/services/workingtimes.service";
  export default {
    name: "WorkingTimes",
  data() {
    return {
      workingtimes_list: null,
    };
  },
  methods: {
    getWorkingtimes: function () {
        get_all_working_times().then((result) => {
        this.workingtimes_list = result.data;
      });
    
    },
  },
  created() {
    this.getWorkingtimes();
  },
};
</script>