<template>
  <Bar
    id="my-chart-id"
    :options="chartOptions"
    :data="{
      labels: date,
      datasets: dataset
    }"
  />
</template>

<script>
import {inject} from 'vue'
import { Bar } from 'vue-chartjs'
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  BarElement,
  Title,
  Tooltip,
  Legend
} from 'chart.js'
import {list} from "postcss";

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  BarElement,
  Title,
  Tooltip,
  Legend
)

export default {
  name: 'LinrChart',
  components: { Bar },
  props: {
    dataset: list,
    date: list
  },
  data() {
    return {
      chartOptions: {
        responsive: true
      }
    }
  }
}


</script>