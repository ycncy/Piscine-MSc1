<template>
  <Pie
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
import { Pie } from 'vue-chartjs'
import {
  Chart as ChartJS,
  ArcElement,
  Tooltip,
  Legend
} from 'chart.js'
import {list} from "postcss";

ChartJS.register(
  ArcElement,
  Tooltip,
  Legend
)

export default {
  name: 'LinrChart',
  components: { Pie },
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