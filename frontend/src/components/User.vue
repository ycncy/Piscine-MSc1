<template>
  <div>
    <Authentication></Authentication>
  </div>
</template>

<script>
  import Authentication from "@/components/Authentication.vue";

  export default {
    name: "User",
    components: {Authentication},
    methods: {
      getUser() {
        sessionStorage.setItem("username", username)
      },
      createUser() {

      },
      updateUser() {

      },
      deleteUser() {

      }
    }
  }
</script>