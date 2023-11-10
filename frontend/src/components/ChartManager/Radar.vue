<template>
  <Radar
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
import { Radar } from 'vue-chartjs'
import {
  Chart as ChartJS,
  RadialLinearScale,
  PointElement,
  LineElement,
  Filler,
  Tooltip,
  Legend
} from 'chart.js'
import {list} from "postcss";

ChartJS.register(
  RadialLinearScale,
  PointElement,
  LineElement,
  Filler,
  Tooltip,
  Legend
)

export default {
  name: 'LineChart',
  components: { Radar },
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