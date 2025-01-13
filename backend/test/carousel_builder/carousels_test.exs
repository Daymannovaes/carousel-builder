defmodule CarouselBuilder.CarouselsTest do
  use CarouselBuilder.DataCase

  alias CarouselBuilder.Carousels

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
      carousel = carousel_fixture()

      settings = %{
        "background_color" => "#000000",
        "font_color" => "#FFFFFF"
      }

      updated_carousel = Carousels.update_all_slides_settings(carousel, settings)

      assert updated_carousel.slides == []
    end

    test "update_all_slides_settings/2 with valid params updates all slides of a carousel" do
      carousel =
        carousel_fixture(%{
          slides: [
            %{
              background_color: "#FFFFFF",
              font_color: "#000000",
              position: 1,
              quill_delta_content: "quill_content_1"
            },
            %{
              background_color: "#FF0000",
              font_color: "#00FF00",
              position: 2,
              quill_delta_content: "quill_content_2"
            }
          ]
        })

      settings = %{
        "background_color" => "#0000FF",
        "font_color" => "#FFFFFF"
      }

      updated_carousel = Carousels.update_all_slides_settings(carousel, settings)

      assert Enum.all?(updated_carousel.slides, fn slide ->
               slide.background_color == "#0000FF" and slide.font_color == "#FFFFFF"
             end)

      assert length(updated_carousel.slides) == 2
    end

    test "update_all_slides_settings/2 with invalid params raises error" do
      carousel = carousel_fixture()

      invalid_settings = %{
        "invalid_field" => "value"
      }

      invalid_params_type = nil

      assert {:error, :bad_request} ==
               Carousels.update_all_slides_settings(carousel, invalid_settings)

      assert {:error, :bad_request} ==
               Carousels.update_all_slides_settings(carousel, invalid_params_type)
    end

    test "update_all_slides_settings/2 with invalid carousel returns nil" do
      invalid_carousel = %Carousel{id: 0}

      settings = %{
        "background_color" => "#0000FF",
        "font_color" => "#FFFFFF"
      }

      assert is_nil(Carousels.update_all_slides_settings(invalid_carousel, settings))
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
