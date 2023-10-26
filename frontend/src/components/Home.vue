<script>
import {defineComponent} from "vue";
import User from "@/components/User.vue";
import Test from "@/components/Test.vue";

export default defineComponent({
  components: {User, Test}
})
</script>

<template>
  <User />
  <Test/>
</template>