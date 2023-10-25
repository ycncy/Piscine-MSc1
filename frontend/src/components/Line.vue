<template>
  <Line
    id="my-chart-id"
    :options="chartOptions"
    :data="chartData"
  />
</template>

<script>
import {users_service} from "../services/users.service.js"
let answer = await users_service.get_user_by_id(2)
let vval = new Date('2023-10-25 5:00:00');
let date1= new Date();
var HoursDiff = (date1.getTime()-vval.getTime()) / (1000 * 60 * 60);
alert(Math.round(HoursDiff))
console.log(answer.data);

let variable = [1,2,3,4]
let variable2 = [5,6,7,8]

let dataone = [{label:"data one",data:variable},{label:"data two",data:variable2}]
import { Line } from 'vue-chartjs'
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
} from 'chart.js'

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
)

export default {
  name: 'LinrChart',
  components: { Line },
  data() {
    return {
      chartData: {
        labels: [ 'January', 'February', 'March' , 'april','may' ],
        datasets: dataone
      },
      chartOptions: {
        responsive: true
      }
    }
  }
}
</script>