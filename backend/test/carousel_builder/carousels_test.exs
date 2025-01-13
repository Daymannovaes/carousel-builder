defmodule CarouselBuilder.CarouselsTest do
  use CarouselBuilder.DataCase

  alias CarouselBuilder.Carousels

  @valid_settings %{
    "background_color" => "#000000",
    "font_color" => "#FFFFFF"
  }

  @invalid_settings %{
    "background_color" => nil,
    "font_color" => nil
  }

  @invalid_settings_fields %{
    "invalid_field" => "invalid value"
  }

  describe "carousels" do
    alias CarouselBuilder.Carousels.Carousel

    import CarouselBuilder.CarouselsFixtures

    @invalid_attrs %{name: nil, is_active: nil}

    test "list_carousels/0 returns all carousels" do
      carousel = carousel_fixture()
      assert Carousels.list_carousels() == [carousel]
    end

    test "get_carousel/1 returns the carousel with given id" do
      carousel = carousel_fixture()
      assert Carousels.get_carousel(carousel.id) == carousel
    end

    test "create_carousel/1 with valid data creates a carousel" do
      valid_attrs = %{name: "some name", is_active: true}

      assert {:ok, %Carousel{} = carousel} = Carousels.create_carousel(valid_attrs)
      assert carousel.name == "some name"
      assert carousel.is_active == true
    end

    test "create_carousel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Carousels.create_carousel(@invalid_attrs)
    end

    test "update_carousel/2 with valid data updates the carousel" do
      carousel = carousel_fixture()
      update_attrs = %{name: "some updated name", is_active: false}

      assert {:ok, %Carousel{} = carousel} = Carousels.update_carousel(carousel, update_attrs)
      assert carousel.name == "some updated name"
      assert carousel.is_active == false
    end

    test "update_carousel/2 with invalid data returns error changeset" do
      carousel = carousel_fixture()
      assert {:error, %Ecto.Changeset{}} = Carousels.update_carousel(carousel, @invalid_attrs)
      assert carousel == Carousels.get_carousel(carousel.id)
    end

    test "update_all_slides_settings/2 with no slides and valid params should not fail" do
      carousel = carousel_fixture(%{slides: []})

      updated_carousel = Carousels.update_all_slides_settings(carousel, @valid_settings)

      assert updated_carousel.slides == []
    end

    test "update_all_slides_settings/2 with valid params updates all slides of a carousel" do
      carousel = carousel_fixture()

      updated_carousel = Carousels.update_all_slides_settings(carousel, @valid_settings)

      assert Enum.all?(updated_carousel.slides, fn slide ->
               slide.background_color == @valid_settings["background_color"] and
                 slide.font_color == @valid_settings["font_color"]
             end)

      assert length(updated_carousel.slides) == 2
    end

    test "update_all_slides_settings/2 with invalid params raises error" do
      carousel = carousel_fixture()

      assert {:error, :bad_request} ==
               Carousels.update_all_slides_settings(carousel, @invalid_settings)

      assert {:error, :bad_request} ==
               Carousels.update_all_slides_settings(carousel, @invalid_settings_fields)

      assert {:error, :bad_request} ==
               Carousels.update_all_slides_settings(carousel, nil)
    end

    test "update_all_slides_settings/2 with invalid carousel returns nil" do
      invalid_carousel = %Carousel{id: 0}

      assert is_nil(Carousels.update_all_slides_settings(invalid_carousel, @valid_settings))
    end

    test "delete_carousel/1 deletes the carousel" do
      carousel = carousel_fixture()
      assert {:ok, %Carousel{}} = Carousels.delete_carousel(carousel)
      assert nil == Carousels.get_carousel(carousel.id)
    end

    test "change_carousel/1 returns a carousel changeset" do
      carousel = carousel_fixture()
      assert %Ecto.Changeset{} = Carousels.change_carousel(carousel)
    end
  end
end
