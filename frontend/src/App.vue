

<template>
  <main>
    <User />
    <router-link :to="this.$route">select</router-link>
    <router-view></router-view>
    <div class="canvas">
    </div>
  </main>
</template>

<script>
import User from './components/User.vue'
import {provide} from 'vue'
import { get_working_times_by_id, get_all_working_times } from "@/services/workingtimes.service";
let userobject =  JSON.parse(localStorage.getItem("user"))
let data =await get_working_times_by_id(userobject.id);
console.log(data)
let time = []
let date = []
let dataset
if(data.data!=null){
  for (let index = 0; index < data.data.length; index++) {
    let start=new Date(data.data[index].start_time)
    let end =new Date(data.data[index].end_time)
    time.push( ( (end.getTime() ) - ( start.getTime() ) ) / (1000 * 60 * 60) ) 
    date.push( start.getDate()+"-"+ start.getMonth());
  }
  dataset = [{label:"Time",data:time}]

}


export default {
  name: 'App',
  components: {
    User
  },setup(){
    provide('date',date)
    provide('datasets',dataset)
  }
}

</script>
<style>
</style>
