<script setup>
import { ref } from "vue";
import axios from "axios";
import { useToast } from "vue-toast-notification";
</script>

<template>
  <!-- IF USER CONNECTED -->
  <!-- MENU -->

  <div class="hero min-h-screen bg-base-200">
    <div class="hero-content flex-col lg:flex-row-reverse">
      <div class="stats stats-vertical shadow">
        <h1 class="text-5xl font-bold">Welcome back @user !</h1>

        <div class="stat">
          <div class="stat-title">Username</div>
          <div class="stat-value">{{ userUsername }}</div>
          <input
            type="text"
            placeholder="New username"
            class="input input-bordered"
            required
            ref="usernameInput"
            v-model="userUsername" />
          <button @click="updateusername" class="btn btn-active">
            UPDATE USERNAME
          </button>
        </div>

        <div class="stat">
          <div class="stat-title">Email</div>
          <div class="stat-value">{{ EMAIL }}</div>
          <input
            type="text"
            placeholder="New email"
            class="input input-bordered"
            required
            ref="emailInput"
            v-model="EMAIL" />
          <button @click="updatemail" class="btn btn-active">
            UPDATE EMAIL
          </button>
        </div>
      </div>

      <div class="card flex-shrink-0 w-full max-w-sm shadow-2xl bg-base-100">
        <form @submit="(event) => event.preventDefault()" class="card-body">
          <h1>DELETE ACCOUNT</h1>
          <div class="form-control">
            <div class="form-control">
              <label class="label">
                <span class="label-text">Username</span>
              </label>
              <input
                type=""
                placeholder="username"
                class="input input-bordered"
                required />
            </div>
            <label class="label">
              <span class="label-text">Email</span>
            </label>
            <input
              type="email"
              placeholder="email@mail.com"
              class="input input-bordered"
              required />
          </div>
          <div class="form-control mt-6">
            <button @click="Deleteacc" class="btn btn-primary">DELETE</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      SignInDiv: true,
      showCreateAccount: false,
      username: "",
      email: "",
      isUserConnected: !!localStorage.getItem("userId"),
      userUsername: null,
      id: null,
      EMAIL: null,
      newusername: null,
      newmail: null,
      newid: null,
    };
  },
  created() {
    // Récupérez la valeur depuis le localStorage
    this.userUsername = localStorage.getItem("userUsername");
    this.id = localStorage.getItem("userId");
    this.EMAIL = localStorage.getItem("userEmail");
  },
  methods: {
    // Mail+ID+ s (GET)
    API() {
      console.log("list of users in process...");
      const email1 = this.email;
      const username1 = this.username;
      axios
        .get(`http://44.207.191.254:4000/api/users`, {
          params: {
            email: email1,
            username: username1,
          },
        })
        .then((response) => {
          console.log("Users found");
          console.log(response.data);
          if (response.data.users) {
            const user = response.data.users[0];

            localStorage.setItem("userEmail", user.email);
            localStorage.setItem("userUsername", user.username);
            localStorage.setItem("userId", user.id);
            this.isUserConnected = true;
          }
        })
        .catch((error) => {
          console.error("API request failed:", error);
        });
    },

    //
    Deleteacc() {
      axios
        .delete(
          `http://44.207.191.254:4000/api/users/` +
            // `http://localhost:4000/api/users/` +
            localStorage.getItem("userId")
        )
        .then((response) => {
          console.log("API response received: USER BEEN DELETED");
          console.log(response.data);
          localStorage.removeItem("userEmail");
          localStorage.removeItem("userUsername");
          localStorage.removeItem("userId");
          this.isUserConnected = false;
          console.log("logging out");
          window.location.replace("/");
          // this.$router.replace("/");
        })
        .catch((error) => {
          console.error("API request failed:", error);
          const $toast = useToast();
          $toast.error("An error occured, please try again later");
        });
    },

    updatemail() {
      this.newmail = this.$refs.emailInput.value;
      console.log(
        "UPDATE MAIL FROM " +
          localStorage.getItem("userId") +
          " TO " +
          this.newmail
      );
      const userId = localStorage.getItem("userId");
      axios
        .put(
          "http://44.207.191.254:4000/api/users/" +
            // "http://localhost:4000/api/users/" +
            userId +
            "?email=" +
            this.newmail
        )
        .then((response) => {
          console.log("API response received: MAIL BEEN UPDATED");
          console.log(response.data);
          const $toast = useToast();
          $toast.success(
            response.data.info + "logout and login to see changes"
          );
        });
    },

    updateid() {
      this.newid = this.$refs.idInput.value;
      console.log(
        "UPDATE ID FROM " + localStorage.getItem("userId") + " TO " + this.newid
      );
      const userId = localStorage.getItem("userId");

      axios
        .put(
          "http://44.207.191.254:4000/api/users/" + userId + "?id=" + this.newid
        )
        .then((response) => {
          console.log("API response received: USER ID BEEN UPDATED");
          console.log(response.data);
        });
    },
    updateusername() {
      this.newusername = this.$refs.usernameInput.value;
      console.log(
        "UPDATE USERNAME FROM " +
          localStorage.getItem("userId") +
          " TO " +
          this.newusername
      );
      const userId = localStorage.getItem("userId");

      axios
        .put(
          // "http://localhost:4000/api/users/" +
          "http://44.207.191.254:4000/api/users/" +
            userId +
            "?username=" +
            this.newusername
        )
        .then((response) => {
          console.log("API response received: uUSERNAME BEEN UPDATED");
          console.log(response.data);
          const $toast = useToast();
          $toast.success(
            response.data.info + "logout and login to see changes"
          );
        });
    },
  },
};
</script>

<style scoped></style>
