<script>
import {provide} from 'vue'
import Bar from './Bar.vue'
import { get_working_times_by_id, get_all_working_times } from "@/services/workingtimes.service";


let data =await get_all_working_times();
console.log(data.data[0])
let time = []

let date = []
for (let index = 0; index < data.data.length; index++) {
  let start=new Date(data.data[index].start_time)
  let end =new Date(data.data[index].end_time)
  time.push( ( (end.getTime() ) - ( start.getTime() ) ) / (1000 * 60 * 60) ) 
  console.log(time)
  date.push( start.getDate()+"-"+ start.getMonth());
}
let dataset = [{label:"Time",data:time}]
export default{
  name:'chart',
  components:{Bar},
  setup(){
    provide('date',date)
    provide('datasets',dataset)
  }
}

</script>
<template>
    <div>
      <select id="s-chart">
          <option value="Bar"> Bar </option>
          <option value="Line"> Line </option>
          <option value="Radar"> Radar</option>
          <option value="Pie"> Pie </option>
      </select>
      <Bar />

    </div>
</template>