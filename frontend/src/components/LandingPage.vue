<script setup>

</script>

<template>
  <main class="landing-container">
    <div class="welcome">
      <h2>Welcome in Time Manager</h2>
      <p>Please, log in using the credentials provided by your team manager</p>
      <form action="">
      <label for="email">Email :</label>
      <input type="email">
      <label for="password">Password :</label>
      <input type="password" name="password" id="password">
    </form>
    <button class="login-button">Log in</button>
    <RouterLink to="/user/dashboard"> Go to the user's dashboard</RouterLink>
    </div>

  </main>
</template>

<style>
.landing-container {
  width: 100vw;
  height: 100vh;
  background-image: url('../assets/images/gotham-city.jpg');
  background-position: center;
  background-size: cover;
  display: flex;
  justify-content: center;
  align-items: center;
}

.welcome {
  width: 50%;
  min-height: 50%;
  background-color: rgba(0, 0, 0, 0.831);
  color: var(--light);
  border-radius: 15px;
  padding: 25px;
  display: flex;
  flex-direction: column;
  /* justify-content: center; */
  align-items: center;
  box-shadow: 2px 2px 6px 1px rgba(108, 108, 108, 0.315);
}

.welcome h2 {
  font-size: 36px;
  font-weight: 600;
  margin-bottom: 15px;
  text-align: center;
}

.welcome p {
  font-size: 18px;
  font-weight: 300;
  font-style: italic;
  text-align: center;
}

.login-button {
  width: 95px;
  height: 40px;
  background-color: green;
  border: none;
  border-radius: 8px;
  color: white;
  box-shadow: 2px 2px 6px 1px rgba(103, 103, 103, 0.315);
}

@media (max-width: 650px) {
  .welcome {
    width: 90%;
  }
}
</style>